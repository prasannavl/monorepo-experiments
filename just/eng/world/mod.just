deps:
    just eng::cpp_lib::build

build: deps
    cargo build

run: deps
    cargo run

test:
    cargo test

fmt: 
    cargo fmt

lint:
    cargo clippy
