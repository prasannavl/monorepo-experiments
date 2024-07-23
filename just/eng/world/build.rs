fn main() {
    let build_root = std::env::var("WORKSPACE_BUILD").unwrap();
    let lib_dir = build_root.to_owned() + "/cpp_lib";
    let clib = "clib";

    println!("cargo:rustc-link-lib={}", clib);
    println!("cargo:rustc-link-search=native={}", lib_dir);
    println!("cargo:rerun-if-changed={}/lib{}.a", lib_dir, clib);
}