build_dir := shell("echo $WORKSPACE_BUILD") + "/cpp_lib"

configure:
    mkdir -p {{build_dir}}
    cmake -S . -B {{build_dir}}

build: configure
    cmake --build {{build_dir}}

clean:
    rm -rf {{build_dir}}