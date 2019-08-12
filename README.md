# CurrencyConverter

Currency is an example app that uses the REST service from Fixer.io to convert currencies.

## App Architecture
MVVM-C is the architecture choosen for this app. The 'C' means Coordinator, an object that is responsible for navigating through screens and dependency injection.

Separation of concern is quite strict, REST servicies are completely separated from the ViewModel. Almost everything is injected using a protocol, this allows testability of each component in isolation.
Unit Test coverage is at 68% (is a small app), and a single UITest is also present.
Swift 5 and Alamofire 5 beta are used. Alamofire is a widley used framework to handle http methods, and makes good use of Swift style of code. Alamofire inclused the Router pattern which is the one used in this app.

## Linting
Swiftlint is used in this project to ensure clean code rules are respected, rules have been modified to be more strict than the default, for example functions are no longer that 15 lines of code. You can read the full list in the .swiftling.yml file

## License

[MIT licensed.](LICENSE)
