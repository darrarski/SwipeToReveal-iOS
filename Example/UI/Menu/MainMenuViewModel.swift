class MainMenuViewModel: MenuViewModel {

    let title = "SwipeToReveal"
    
    let items: [MenuItemViewModel] = [
        PushMenuItemViewModel(title: "Menu Item 1"),
        PushMenuItemViewModel(title: "Menu Item 2"),
        PushMenuItemViewModel(title: "Menu Item 3")
    ]

}
