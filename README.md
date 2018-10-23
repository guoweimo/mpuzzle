## MPuzzle

This project is to solve the 4x5 board problem, which similar as the well-known Klotski, or HuangRongDao (華容道 in Chinese).

### Language and Project
The project is written in **swift**, the current main and preferred language for iOS development. 
#### Reasons for choosing it:
- My main tech background is iOS Dev. And this is my most frequent used language.
-  **Swift** is powerful, clean and type-safe. 
- iOS is perfect for building up user interface.

#### Run the project
open project in Xcode.
- run tests, or add your own test cases.  Choose target **MPuzzleTests**, and run the tests.  *GameTests.swift* is the main tests for the whole game solution.
- run the project to see the UI demo.  Choose a simulator, and click "▶︎" on top right in Xcode to run the app. When app shows, click "**Solve**" button to see each moves.

### Assumption and Discussion
- The solution is based on the requirement provided, and also cross-verify with the actual Klotski problem.  And the result is proved to be the optimal solution  based on the current algorithmic research.
- The solution is for demo only. And currently only two test cases are in the tests. The main entry point is in *Game.swift,* where we can pass in any different starting pieces state. Also, invalid state (e.g. no 2x2 piece) will fail to start a game. This is scalable and flexible, and very modular, easily supporting extension and integration. 
- Solution is **100%** tests covered. (except ViewController.swift which if for UI)
- Due to time constraint, the UI in the app is pretty basic. But it is easy to polish it if needed. 
