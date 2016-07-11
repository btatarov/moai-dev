--==============================================================
-- args
--==============================================================

OUTPUT_DIR				       = INVOKE_DIR .. 'Hosts/' .. SCRIPT_PARAM .. '/' -- usually amazon/googleplay
MOAI_JAVA_NAMESPACE		       = 'com.ziplinegames.moai'

ANT_DIR							= OUTPUT_DIR .. 'ant/'
MOAI_PROJECT_PATH				= ANT_DIR .. 'project/'

MODULES							= {}
ALL_MODULES						= {}

MODULE_APP_DECLARATIONS			= ''
MODULE_MANIFEST_PERMISSIONS		= ''
MODULE_PROJECT_INCLUDES			= ''

COPY							= {}

----------------------------------------------------------------
local config 						= { INVOKE_DIR = INVOKE_DIR }

config.PROJECT_NAME					= 'MoaiSample'
config.PACKAGE_NAME					= 'com.ziplinegames.moaisample'
config.PLATFORM_NAME				= 'android'

config.LUA_WORKING_DIR				= 'bundle/assets/lua'
config.LUA_MAIN						= 'main.lua'

config.MANIFEST_DEBUGGABLE			= 'false'
config.ANDROID_PLATFORM_TARGET		= 'android-17'
config.VALID_ARCHITECTURES			= { 'armeabi', 'armeabi-v7a', 'x86' }

config.COPY							= {}

--==============================================================
-- util
--==============================================================

local importBin
local importLib
local importSrc
local processConfigFile
local processModulesFiles

local projectCounter = 0

----------------------------------------------------------------
local importBin = function ( path )

	if not path then return end

	for _, arch in ipairs(config.VALID_ARCHITECTURES) do
		local newpath = string.gsub(path, '<arch>', arch)
		local filename = util.getFilenameFromPath(newpath)

		MOAIFileSystem.affirmPath(MOAI_PROJECT_PATH .. 'libs/' .. arch .. '/')
		MOAIFileSystem.copy(newpath, MOAI_PROJECT_PATH .. 'libs/' .. arch .. '/' .. filename)
	end
end

----------------------------------------------------------------
local importLib = function ( path )

	if not path then return end

	local srcPath = path .. 'src/'
	if MOAIFileSystem.checkPathExists ( srcPath ) then
		MOAIFileSystem.copy (  srcPath, MOAI_PROJECT_PATH .. 'src/' )
	end

	local libPath = path .. 'lib/'
	if MOAIFileSystem.checkPathExists ( libPath ) then
		for i, filename in ipairs ( util.listFiles ( libPath, 'jar' )) do
			MOAIFileSystem.copy (  libPath .. filename, MOAI_PROJECT_PATH .. 'libs/' .. filename )
		end
	end

	local projectPath = path .. 'project/'
	if MOAIFileSystem.checkPathExists ( projectPath ) then
		for i, pathname in ipairs ( util.listDirectories ( projectPath )) do
			projectCounter = projectCounter + 1

			MOAIFileSystem.copy (  projectPath .. pathname, ANT_DIR .. pathname )
			MODULE_PROJECT_INCLUDES = MODULE_PROJECT_INCLUDES ..
					string.format ( 'android.library.reference.%d=../%s/\n', projectCounter, pathname )
		end
	end

	local appDeclarationsPath = path .. 'manifest_declarations.xml'

	if MOAIFileSystem.checkFileExists ( appDeclarationsPath ) then
		local fp = io.open ( appDeclarationsPath, "r" )
		MODULE_APP_DECLARATIONS = MODULE_APP_DECLARATIONS .. '\n' .. fp:read ( "*all" )
		fp:close ()
	end

	local manifestPermissionsPath = path .. 'manifest_permissions.xml'
	if MOAIFileSystem.checkFileExists ( manifestPermissionsPath ) then
		local fp = io.open ( manifestPermissionsPath, "r" )
		MODULE_MANIFEST_PERMISSIONS = MODULE_MANIFEST_PERMISSIONS .. '\n' .. fp:read ( "*all" )
		fp:close ()
	end
end

----------------------------------------------------------------
local importSrc = function ( path, namespace )

	if not path then return end

	local projectSrcFolder	= string.format ( '%ssrc/%s/', MOAI_PROJECT_PATH, string.gsub ( namespace, '%.', '/' ))

	local files = util.listFiles ( path, 'java' )
	for i, filename in ipairs ( files ) do
		MOAIFileSystem.copy (  path .. filename, projectSrcFolder .. filename )
	end
end

----------------------------------------------------------------
processConfigFile = function ( filename )

	filename = MOAIFileSystem.getAbsoluteFilePath ( filename )
	if not MOAIFileSystem.checkFileExists ( filename ) then return end
	local configPath = util.getFolderFromPath ( filename )

	local configFile = { MOAI_SDK_HOME = MOAI_SDK_HOME }
	util.dofileWithEnvironment ( filename, configFile )

	for k, v in pairs ( configFile ) do
		config [ k ] = v
	end
end

----------------------------------------------------------------
processModulesFile = function ( filename )

	filename = MOAIFileSystem.getAbsoluteFilePath ( filename )
	if not MOAIFileSystem.checkFileExists ( filename ) then return end
	local configPath = util.getFolderFromPath ( filename )

	local modFile = { MOAI_SDK_HOME = MOAI_SDK_HOME }
	util.dofileWithEnvironment ( filename, modFile )

	local modTable = {
		MODULES = {}
	}
	for i, mod in ipairs(config['MODULES']) do
		modTable['MODULES'][mod] = modFile['MODULES'][mod]
	end

	config['MODULES'] = modTable['MODULES']
end

----------------------------------------------------------------
local resolvePath = function ( path )
	return path and ( string.find ( path, '^/' ) and path or SCRIPT_DIR .. path )
end

-- =============================================================
-- Main
-- =============================================================
processConfigFile('config.lua')

-- apply hosts.lua
local host_config = INVOKE_DIR .. 'hosts.lua'
assert(MOAIFileSystem.checkFileExists(host_config), "You need to have hosts.lua configured in your project directory.")

local STORE = string.upper(SCRIPT_PARAM)
util.dofileWithEnvironment(host_config, config)

assert(config['HOST_SETTINGS']['ANDROID'][STORE], "Config file error.") -- always crash here on mistakes

-- first copy main params
for k, v in pairs ( config['HOST_SETTINGS']['ANDROID'] ) do

	-- only simple params or icon tables
	if type(v) ~= 'table' or k == 'ICONS' then
		config[k] = v
	end
end

-- copy and override existing host-specific params
for k, v in pairs (config['HOST_SETTINGS']['ANDROID'][STORE]) do

	if k == 'MODULES' then
		for i, mod in ipairs(config['HOST_SETTINGS']['ANDROID'][STORE]['MODULES']) do
			table.insert(config['MODULES'], mod)
		end

	else
    	config[k] = v
	end
end
config['HOST_SETTINGS'] = nil

-- Project game files
table.insert ( config.COPY, { src = config.LUA_MAIN_DIR, dst = 'assets/lua' } )

-- convert module list to module LUT
processModulesFile('modules.lua')

for name, mod in pairs (config['MODULES']) do
	local src = resolvePath ( mod.src )
	local lib = resolvePath ( mod.lib )
	local bin = resolvePath ( mod.bin )

	MODULES [ name ] = {
		namespace = mod.namespace,
		src = src and MOAIFileSystem.getAbsoluteDirectoryPath ( src ),
		lib = lib and MOAIFileSystem.getAbsoluteDirectoryPath ( lib ),
		bin = bin and MOAIFileSystem.getAbsoluteFilePath ( bin ),

		-- true or nil (for facebook and gamecircle projects)
		project = mod.project,
		project_name = name,
	}
end

if config.COPY then
	for i = 1, #config.COPY do
		COPY [ MOAI_PROJECT_PATH .. config.COPY[i].dst ] = resolvePath(config.COPY[i].src)
	end
end

MOAIFileSystem.deleteDirectory(OUTPUT_DIR, true)
MOAIFileSystem.affirmPath(ANT_DIR)


MOAIFileSystem.copy(
	MOAI_SDK_HOME .. '/host-templates/android/studio/MoaiTemplate/app/bootstrap/bootstrap.lua',
	MOAI_PROJECT_PATH .. '/assets/lua/bootstrap.lua'
)

MOAIFileSystem.copy(
	MOAI_SDK_HOME .. '/host-templates/android/studio/MoaiTemplate/app/bootstrap/init.lua',
	MOAI_PROJECT_PATH .. '/assets/lua/init.lua'
)

if config.KEYSTORE_NAME then
	local keystore_path = MOAIFileSystem.getAbsoluteFilePath(config.KEYSTORE_PATH .. config.KEYSTORE_NAME)
	MOAIFileSystem.copy(keystore_path, MOAI_PROJECT_PATH .. config.KEYSTORE_NAME)
end

for name, mod in pairs(MODULES) do
	importSrc(mod.src, mod.namespace or MOAI_JAVA_NAMESPACE)
	importLib(mod.lib)
	importBin(mod.bin)
end

for dst, src in pairs ( COPY ) do
	MOAIFileSystem.copy ( src, dst )
end

MOAIFileSystem.copy('project', MOAI_PROJECT_PATH)
MOAIFileSystem.copy('run-host.sh', OUTPUT_DIR .. 'run-host.sh')
util.makeExecutable(OUTPUT_DIR .. 'run-host.sh')

for icon_name, icon_path in pairs(config.ICONS) do
	MOAIFileSystem.copy(icon_path, string.format('%s/res/drawable-%s/icon.png', MOAI_PROJECT_PATH, icon_name))
end

util.replaceInFiles ({

	[ MOAI_PROJECT_PATH .. 'AndroidManifest.xml' ] = {
		[ '@EXTERNAL_APPLICATION_ENTRIES@' ]	= MODULE_APP_DECLARATIONS,
		[ '@EXTERNAL_MANIFEST_PERMISSIONS@' ] 	= MODULE_MANIFEST_PERMISSIONS,
		[ '@DEFAULT_ORIENTATION@' ]				= config.DEFAULT_ORIENTATION
	},

	[ MOAI_PROJECT_PATH .. 'project.properties' ] = {
		[ '@EXTERNAL_PROJECT_INCLUDES@' ] 		= MODULE_PROJECT_INCLUDES,
	},
})

if config.REVMOB_APP_ID then
	util.replaceInFiles ({
		[ MOAI_PROJECT_PATH .. 'AndroidManifest.xml' ] = {
			[ '@REVMOB_APP_ID@' ]				= config.REVMOB_APP_ID,
		},
	})
end

util.replaceInFiles ({

	[ OUTPUT_DIR .. 'run-host.sh' ] = {
		[ '@PACKAGE@' ]							= config.PACKAGE_NAME,
	},

	[ MOAI_PROJECT_PATH .. '.project' ] = {
		[ '@NAME@' ]							= config.PROJECT_NAME,
	},

	[ MOAI_PROJECT_PATH .. 'build.xml' ] = {
		[ '@NAME@' ]							= config.PROJECT_NAME,
	},

	[ MOAI_PROJECT_PATH .. 'AndroidManifest.xml' ] = {
		[ '@NAME@' ]							= config.PROJECT_NAME,
		[ '@PACKAGE@' ]							= config.PACKAGE_NAME,
		[ '@VERSION_CODE@' ]					= config.VERSION_CODE,
		[ '@VERSION_NAME@' ]					= config.VERSION_NAME,
		[ '@DEBUGGABLE@' ]						= config.MANIFEST_DEBUGGABLE,
		[ '@FACEBOOK_APP_ID@' ]					= config.FACEBOOK_APP_ID,
		[ '@EXTERNAL_APPLICATION_ENTRIES@' ]	= MODULE_APP_DECLARATIONS,
		[ '@EXTERNAL_MANIFEST_PERMISSIONS@' ] 	= MODULE_MANIFEST_PERMISSIONS,
	},

	[ MOAI_PROJECT_PATH .. 'ant.properties' ] = {
		[ '@KEY_STORE@' ]						= config.KEYSTORE_NAME,
		[ '@KEY_ALIAS@' ]						= config.KEYSTORE_ALIAS,
		[ '@KEY_STORE_PASSWORD@' ]				= config.KEYSTORE_PASSWORD,
		[ '@KEY_ALIAS_PASSWORD@' ]				= config.KEYSTORE_ALIAS_PASSWORD,
	},

	[ util.wrap ( util.iterateFilesAbsPath, MOAI_PROJECT_PATH, '^local.properties$' )] = {
		[ '@SDK_ROOT@' ]						= '$ANDROID_HOME',
	},

	[ MOAI_PROJECT_PATH .. 'project.properties' ] = {
		[ '@EXTERNAL_PROJECT_INCLUDES@' ] 		= MODULE_PROJECT_INCLUDES,
	},

	[ MOAI_PROJECT_PATH .. 'res/values/strings.xml' ] = {
		[ '@APP_NAME@' ] 						= config.APP_NAME,
		[ '@GOOGLE_APP_ID@' ] 					= config.GOOGLE_PLAY_APP_ID,
		[ '@FACEBOOK_APP_ID@' ]					= config.FACEBOOK_APP_ID,
	},

	[ util.wrap ( util.iterateFilesAbsPath, MOAI_PROJECT_PATH .. 'src', '.java$' )] = {
		[ '@PACKAGE@' ]							= config.PACKAGE_NAME,
		[ '@PLATFORM_NAME@' ]					= string.upper ( config.PLATFORM_NAME ),
		[ '@RUN_SCRIPTS@' ]						= config.LUA_MAIN,
		[ '@WORKING_DIR@' ]						= config.LUA_WORKING_DIR,
		[ '@KEY_ALIAS_PASSWORD@' ]				= config.KEYSTORE_ALIAS_PASSWORD,
		[ '@BASE_64_PUBLIC_KEY@' ]				= config.BASE64_PUBLIC_KEY,
	},
})

os.execute ( string.format ( 'android update project --target %s --path %s',
	tostring ( config.ANDROID_PLATFORM_TARGET ),
	MOAI_PROJECT_PATH
))

-- update library projects
for name, mod in pairs(MODULES) do
	if mod.project then
		os.execute ( string.format ( 'android update project --target %s --path %s',
			tostring ( config.ANDROID_PLATFORM_TARGET ),
			ANT_DIR .. mod.project_name
		))
	end
end
