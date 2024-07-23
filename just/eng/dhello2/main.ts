import chalk from "chalk";
import { sayHello } from "@root/eng/dhello/lib.ts";

function main() {
    console.log(chalk.green("msg: ") + sayHello());
}

main();