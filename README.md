<img src="https://github.com/mosliem/Upenny/blob/main/Screenshots/180.png" width=100 height=100 />

<h1 align= "left"> Upenny </h1>

<br>

Upenny is an iOS app that tracks user money transactions (expense or income). It enables the user to add new expenses or incomes and specify his category with a note and icon. It provides the user with a weekly or monthly report about his expenses and the percentage of expenses for each category to all that was spent. Provides an account history for income and expense transactions done before.

<br>
<p align="center">
<img src="https://github.com/mosliem/Upenny/blob/main/Screenshots/banner%403x.png" />
</p>


## Built with

- MVP Design architecture
- Swift 5.3 and UIKit 
- [Realm](https://github.com/realm/realm-swift) 
- [Charts](https://github.com/danielgindi/Charts)
- [BetterSegmentedControl](https://github.com/gmarm/BetterSegmentedControl)
- [Lottie-ios](https://github.com/airbnb/lottie-ios)
- [MemojiView](https://github.com/emrearmagan/MemojiView)

## Getting Started
### Prerequisites
- Xcode 12.4 or higher
- iOS 13 or higher
- install the latest version of cocoapods 

       sudo gem install cocoapods
     
- <h3> Don't forget Pods install </h3>

        pod install
        
        
## Usage
This a small demo video about the main features

https://user-images.githubusercontent.com/52772674/187349767-f067e2ce-5dfb-4daa-9750-980fea66b0e0.mp4


## Features

- add or delete transactions(income or expense) from account history.
- locally saves all transactions using Realm.
- add a note for a transaction and choose a customized icon for its category.
- View all transactions done on account history.
- view a weekly or monthly report about all expenses showing total expenses, a bar chart visualize it and all categories and percentage of its expense to the total spent.


## App Structrue

- Upenny
   - Core 
     - AppDelegate
     - SceneDelegate
     
   - Resources
     - Extensions
     - info.plist
     
   - Scenes  
     - Splash Screen 
     - Tab Bar
     - Daily Transactions
     - Account History Details
     - Transactions Chart
     - Add Transaction
     - Transaction Details
     - Category Expenses Details
    
   - Storage
     - Data models
     - Realm manger
  
  
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.
  
<h3 align="left">Connect with me</h3>

 -  Mohamed Sliem - mohamedmostafa191299@gmail.com
 -  [Linkedin](https://www.linkedin.com/in/mohamed-sliem-662491172/)
