--==============================================================
-- args
--==============================================================
local config = {}
local hostconfig = {

    MOAI_SDK_HOME = MOAI_SDK_HOME,
    INVOKE_DIR    = INVOKE_DIR,
}

config.OUTPUT_DIR   = INVOKE_DIR .. 'Hosts/ios/'
config.LIB_SOURCE   = MOAI_SDK_HOME .. 'lib/ios'

--==============================================================
-- util
--==============================================================
local configureHost
local copyHostFiles
local copyLibraryFiles
local processConfigFile
local processModulesFile

----------------------------------------------------------------
configureHost = function ()

    local output = config.OUTPUT_DIR

    --get lua folder path (relative to xcode project)
    local fullLua = MOAIFileSystem.getAbsoluteDirectoryPath ( hostconfig[ 'LUA_MAIN_DIR' ] )

    local relativeLua = MOAIFileSystem.getRelativePath ( fullLua, output )
    relativeLua = string.match ( relativeLua, '(.*)/$' ) -- strip trailing slash

    local luafolder = string.match( fullLua, '.*/([^/]-)/$' ) -- strip trailing slash

    local projectfiles = {
        [ output..'Moai Template.xcodeproj/project.xcworkspace/contents.xcworkspacedata' ] = true,
        [ output..'Moai Template.xcodeproj/xcshareddata/xcschemes/Moai Template.xcscheme' ] = true
    }

    local orientationString
    if hostconfig [ 'DEFAULT_ORIENTATION' ] == 'portrait' then
        orientationString = '<string>UIInterfaceOrientationPortrait</string>\n<string>UIInterfaceOrientationPortraitUpsideDown</string>'
    else
        orientationString = '<string>UIInterfaceOrientationLandscapeLeft</string>\n<string>UIInterfaceOrientationLandscapeRight</string>'
    end

    util.replaceInFiles ({
        [ output..'Moai Template.xcodeproj/project.pbxproj' ] = {
            --our lua path
            [ '(63D01EC01A38659C0097C3E8%C-name = )([^;]-)(;.-path = )([^;]-)(;.*)' ] = "%1"..'"'..luafolder..'"'.."%3"..'"'..relativeLua..'"'.."%5",
            --our app name
            [ 'Moai Template' ] = hostconfig[ 'APP_NAME' ],
            [ '%$%(MOAI_SDK_HOME%)' ] = string.match ( MOAI_SDK_HOME, '(.*)/$' ),
            [ '@IOS_TARGET@' ] = hostconfig[ 'IOS_TARGET' ],
            [ '@DEVELOPMENT_TEAM@' ] = hostconfig[ 'DEVELOPMENT_TEAM' ],
        },

        [ util.wrap(pairs, projectfiles) ] = {
            ['Moai Template'] = hostconfig [ 'APP_NAME' ],
        },

        [ output..'main.lua' ] = {
            [ 'setWorkingDirectory%(.-%)' ] = 'setWorkingDirectory("' .. luafolder .. '")'
        },

        [ output..'main64.lua' ] = {
            [ 'setWorkingDirectory%(.-%)' ] = 'setWorkingDirectory("' .. luafolder .. '")'
        },

        [ output .. 'res/Info.plist' ] = {
            [ '@BUNDLE_ID@' ] = hostconfig[ 'BUNDLE_ID' ],
            [ '@VERSION@' ] = hostconfig[ 'VERSION' ],
            [ '@BUILD_NUMBER@' ] = hostconfig[ 'BUILD_NUMBER' ],
            [ '@FB_APP_ID@' ] = hostconfig[ 'FB_APP_ID' ],
            [ '@FB_APP_NAME@' ] = hostconfig[ 'FB_APP_NAME' ],
            [ '@APPLOVIN_SDK_KEY@' ] = hostconfig[ 'APPLOVIN_SDK_KEY' ],
            [ '<string>UIInterfaceOrientationPortrait</string>' ] = orientationString,
        }
    })

    --rename the scheme
    MOAIFileSystem.copy(output..'Moai Template.xcodeproj/xcshareddata/xcschemes/Moai Template.xcscheme',
    output..'Moai Template.xcodeproj/xcshareddata/xcschemes/'..hostconfig['APP_NAME']..'.xcscheme')
    MOAIFileSystem.deleteFile(output..'Moai Template.xcodeproj/xcshareddata/xcschemes/Moai Template.xcscheme')

    --rename the project file
    MOAIFileSystem.copy ( output .. 'Moai Template.xcodeproj', output .. hostconfig[ 'APP_NAME' ] .. '.xcodeproj' )
    MOAIFileSystem.deleteDirectory ( output .. 'Moai Template.xcodeproj', true )

    -- copy icons
    if ( hostconfig[ 'ICONS' ] ) then

        local icons = MOAIFileSystem.getAbsoluteDirectoryPath ( hostconfig[ 'ICONS' ] )

        if ( MOAIFileSystem.checkPathExists ( icons ) ) then

            MOAIFileSystem.deleteDirectory ( config.OUTPUT_DIR .. 'res/Images.xcassets/AppIcon.appiconset' )
            MOAIFileSystem.copy ( icons, config.OUTPUT_DIR .. 'res/Images.xcassets/AppIcon.appiconset' )
        else

            error ( 'Could not find specified icon assets:' .. icons .. ' - skipping' )
        end
    end

    -- copy launch images
    if ( hostconfig[ 'LAUNCH_IMAGES' ] ) then

        local icons = MOAIFileSystem.getAbsoluteDirectoryPath ( hostconfig[ 'LAUNCH_IMAGES' ] )

        if ( MOAIFileSystem.checkPathExists ( icons ) ) then

            MOAIFileSystem.deleteDirectory ( config.OUTPUT_DIR .. 'res/Images.xcassets/LaunchImage.launchimage' )
            MOAIFileSystem.copy ( icons, config.OUTPUT_DIR .. 'res/Images.xcassets/LaunchImage.launchimage' )
        else

            error ( 'Could not find specified icon assets:' .. icons .. ' - skipping' )
        end
    end
end

----------------------------------------------------------------
copyHostFiles = function ()

	local output = config.OUTPUT_DIR
    MOAIFileSystem.affirmPath ( output )
    print ( 'Creating: ' .. output )

	for  entry in util.iterateFiles ( SCRIPT_DIR .. '/project', false, true ) do

		local fullpath = string.format ( '%s/project/%s', SCRIPT_DIR, entry )
		MOAIFileSystem.copy ( fullpath, output .. entry )
	end

    --we want the copy from src
    MOAIFileSystem.deleteDirectory ( output .. 'host-ios' )
	MOAIFileSystem.deleteDirectory ( output .. 'host-modules', true )

    local classes = MOAI_SDK_HOME .. 'src/host-ios'
    local hostmodules = MOAI_SDK_HOME .. 'src/host-modules'

    MOAIFileSystem.copy ( classes, output .. 'host-ios' )
    MOAIFileSystem.copy ( hostmodules, output .. 'host-modules' )

    MOAIFileSystem.deleteFile ( output .. 'host-modules/aku_modules_android.h' )
    MOAIFileSystem.deleteFile ( output .. 'host-modules/aku_modules_android_config.h' )
    MOAIFileSystem.deleteFile ( output .. 'host-modules/aku_modules_android.cpp' )
end

----------------------------------------------------------------
copyLibraryFiles = function()

	MOAIFileSystem.copy ( config.LIB_SOURCE, config.OUTPUT_DIR .. 'libmoai' )

    -- copy frameworks
    for _, framework in ipairs ( hostconfig[ 'FRAMEWORKS' ] ) do

        MOAIFileSystem.copy ( MOAIFileSystem.getAbsoluteDirectoryPath ( framework ),
                              config.OUTPUT_DIR .. 'libmoai/' .. util.getFilenameFromPath ( framework ) )
    end

    -- copy extra modules
    for _, module in ipairs ( hostconfig[ 'EXTRA_MODULES' ] ) do

        MOAIFileSystem.copy ( MOAIFileSystem.getAbsoluteDirectoryPath ( module ),
                              config.OUTPUT_DIR .. 'libmoai/' .. util.getFilenameFromPath ( module ) )
    end
end

----------------------------------------------------------------
processConfigFile = function ( configFile )

    configFile = MOAIFileSystem.getAbsoluteFilePath ( INVOKE_DIR .. configFile )
    assert ( MOAIFileSystem.checkFileExists ( configFile ),
             'You need to have hosts.lua configured in your project directory.' )

    util.dofileWithEnvironment ( configFile, hostconfig )
    assert ( hostconfig[ 'HOST_SETTINGS' ][ 'IOS' ], 'Config file error.' ) -- always crash here on mistakes

    --copy host specific settings to main config
    for k, v in pairs ( hostconfig[ 'HOST_SETTINGS' ][ 'IOS' ] ) do

        hostconfig[k] = v
    end

    hostconfig[ 'HOST_SETTINGS' ] = nil
end

----------------------------------------------------------------
processModulesFile = function ( filename )

	local filename = MOAIFileSystem.getAbsoluteFilePath ( SCRIPT_DIR .. filename )

	local modules = { MOAI_SDK_HOME = MOAI_SDK_HOME }
	util.dofileWithEnvironment ( filename, modules )

	local framework_table = {}
	for i, framework in ipairs ( hostconfig[ 'FRAMEWORKS' ] ) do

		for _, path in ipairs( modules[ 'FRAMEWORKS' ][ framework ] ) do

            table.insert ( framework_table, path )
        end
	end

    hostconfig[ 'FRAMEWORKS' ] = framework_table
    hostconfig[ 'EXTRA_MODULES' ] = modules[ 'EXTRA_MODULES' ]
end

-- =============================================================
-- Main
-- =============================================================
MOAIFileSystem.setWorkingDirectory ( INVOKE_DIR )

processConfigFile ( 'hosts.lua' )
processModulesFile ( 'modules.lua' )

copyHostFiles ()
copyLibraryFiles ()

configureHost ()

print ( 'Done.' )
