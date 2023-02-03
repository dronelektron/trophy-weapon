void Menu_GiveTrophyWeapon(int client) {
    Menu menu = new Menu(MenuHandler_GiveTrophyWeapon);

    menu.SetTitle("%T", GIVE_TROPHY_WEAPON, client);

    Menu_AddItem(menu, ITEM_YES, client);
    Menu_AddItem(menu, ITEM_NO, client);

    menu.ExitButton = false;
    menu.Display(client, ASK_FOR_TROPHY_WEAPON_TIME);
}

public int MenuHandler_GiveTrophyWeapon(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        if (StrEqual(info, ITEM_YES)) {
            UseCase_GiveTrophyWeapon(param1);
        } else {
            Weapon_ResetTrophy(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_AddItem(Menu menu, const char[] phrase, int client) {
    char item[ITEM_MAX_SIZE];

    Format(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(phrase, item);
}
