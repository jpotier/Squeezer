#!/bin/bash

# select platform
case $1 in
	1)
		PLATFORM="debug_x64"
		PLATFORM_PRINT="64-bit (Debug)"
		EXECUTABLE_EXTENSION="_debug_x64"
		;;
	2)
		PLATFORM="release_x64"
		PLATFORM_PRINT="64-bit (Release)"
		EXECUTABLE_EXTENSION="_x64"
		;;
	3)
		PLATFORM="debug_x32"
		PLATFORM_PRINT="32-bit (Debug)"
		EXECUTABLE_EXTENSION="_debug"
		;;
	4)
		PLATFORM="release_x32"
		PLATFORM_PRINT="32-bit (Release)"
		EXECUTABLE_EXTENSION=""
		;;
	*)
		echo
		echo "  Usage:  mz_build PLATFORM TARGET [BUILD_OPTIONS]"
		echo
		echo
		echo "  Platform:  ..."
		echo
		echo "  1: 64-bit (Debug)"
		echo "  2: 64-bit (Release)"
		echo
		echo "  3: 32-bit (Debug)"
		echo "  4: 32-bit (Release)"
		echo
		exit
esac

echo
echo "  Platform: " $PLATFORM_PRINT

# get next command line option
shift 1

# select target
case $1 in
	a)
		MAKEFILE="all"
		MAKEFILE_PRINT="all targets"
		;;
	c)
		MAKEFILE="clean"
		MAKEFILE_PRINT="clean targets"
		;;
	1)
		MAKEFILE="squeezer_standalone_stereo"
		MAKEFILE_PRINT="Standalone (Stereo)"
		EXECUTABLE="squeezer_stereo"
		;;
	2)
		MAKEFILE="squeezer_standalone_mono"
		MAKEFILE_PRINT="Standalone (Mono)"
		EXECUTABLE="squeezer_mono"
		;;
	3)
		MAKEFILE="squeezer_lv2_stereo"
		MAKEFILE_PRINT="LV2 plug-in (Stereo)"
		;;
	4)
		MAKEFILE="squeezer_lv2_mono"
		MAKEFILE_PRINT="LV2 plug-in (Mono)"
		;;
	5)
		MAKEFILE="squeezer_vst_stereo"
		MAKEFILE_PRINT="VST plug-in (Stereo)"
		;;
	6)
		MAKEFILE="squeezer_vst_mono"
		MAKEFILE_PRINT="VST plug-in (Mono)"
		;;
	7)
		MAKEFILE="squeezer_vst_stereo_no_sidechain"
		MAKEFILE_PRINT="VST plug-in (Stereo, no side-chain)"
		;;
	8)
		MAKEFILE="squeezer_vst_mono_no_sidechain"
		MAKEFILE_PRINT="VST plug-in (Mono, no side-chain)"
		;;
	*)
		echo "  Target:    ..."
		echo
		echo "  a: All targets"
		echo "  c: Clean targets"
		echo
		echo "  1: Standalone (Stereo)"
		echo "  2: Standalone (Mono)"
		echo "  3: LV2 plug-in (Stereo)"
		echo "  4: LV2 plug-in (Mono)"
		echo "  5: VST plug-in (Stereo)"
		echo "  6: VST plug-in (Mono)"
		echo "  7: VST plug-in (Stereo, no side-chain)"
		echo "  8: VST plug-in (Mono, no side-chain)"
		echo
		exit
esac

echo "  Target:   " $MAKEFILE_PRINT

# get next command line option
shift 1

# display additional options
if [ -z $1 ]; then
	echo "  Options:   --no-print-directory"
	echo
else
	echo "  Options:  --no-print-directory" $*
	echo
fi

# indent and format code
if [ "$MAKEFILE" != "clean" ]; then
	echo "==== Indenting and formatting code ===="
	cd "../Source"
	"./format_code.sh"
	cd "../Builds"
	echo
fi

# compile target
make --directory=linux/gmake/ --no-print-directory config=$PLATFORM $MAKEFILE $* 2>&1

# compilation was successful
if [ $? -eq 0 ]; then
	echo $MAKEFILE | grep "_standalone_"

	# target is standalone, so execute file
	if [ $? -eq 0 ]; then
		echo
		../bin/standalone/$EXECUTABLE$EXECUTABLE_EXTENSION
	fi
fi
