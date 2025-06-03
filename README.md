### Summary: Include screen shots or a video of your app highlighting its features

https://github.com/user-attachments/assets/7feb8996-d681-4403-afaf-cc699aabc8d2

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I priorited the project requirements, with my highest priority being the use of pure Swift Concurrency throughout the app. I specifically avoided using AsyncImage for automatic caching and recipe list management because it abstracts away caching logic that I wanted full control over. While using an out-of-the-box solution would have been easier, the requirements emphasized using async/await not just for network calls but also for caching. This led me to implement a custom caching solution using Swift Concurrency, ensuring I could meet all requirements and have fine-grained control over the caching logic.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time? 
I spent about 6 hours on this project. The majority of my time (about 4–5 hours) was devoted to ensuring all requirements were met. The remaining time was spent on UI/UX improvements and making the app scalable, which included refactoring code and maximizing code reuse wherever possible.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I did not implement sorting or filtering in order to focus on making the core features robust such as the Network and API manager. I also ensured that fetch statuses were not tightly coupled to any specific view model or component. Additionally, I wrote multiple tests to verify that image caching and network calls functioned as expected.

### Weakest Part of the Project: What do you think is the weakest part of your project?
UI can be improved, especially in landscape mode. More components could be extracted for reuse, such as view modifiers. Additionally, more tests, tests especially UI tests could be written.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I hope the app works as intended. If you have any feedback, I would greatly appreciate it!
