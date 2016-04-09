set -e

# check for command line switches
usage="usage: $0 [--clean]"

while [ $# -gt 0 ];	do
    case "$1" in
		--clean)  clean=true; break;;
		*)
	    	echo >&2 \
	    		$usage
	    	exit 1;;
    esac
    shift
done

if [ "$clean" == "true" ]; then
    source libmoai-clean.sh

    build_cmd="ndk-build -j4 -B"
else
    build_cmd="ndk-build -j4"
fi

pushd libmoai/jni > /dev/null
$build_cmd
popd > /dev/null
