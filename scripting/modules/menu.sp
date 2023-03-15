void Menu_AddToPreferences() {
    SetCookieMenuItem(MenuHandler_TrophyWeaponMode, 0, TROPHY_WEAPON);
}

public void MenuHandler_TrophyWeaponMode(int client, CookieMenuAction action, any info, char[] buffer, int maxLength) {
    if (action == CookieMenuAction_SelectOption) {
        Menu_Settings(client);
    } else {
        Format(buffer, maxLength, "%T", TROPHY_WEAPON, client);
    }
}

public void Menu_Settings(int client) {
    Menu menu = new Menu(MenuHandler_Settings);

    menu.SetTitle("%T", TROPHY_WEAPON, client);

    Menu_AddModeItem(menu, COOKIE_VALUE_ASK, ITEM_ASK, client);
    Menu_AddModeItem(menu, COOKIE_VALUE_GIVE_ALWAYS, ITEM_GIVE_ALWAYS, client);
    Menu_AddModeItem(menu, COOKIE_VALUE_GIVE_NEVER, ITEM_GIVE_NEVER, client);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Settings(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        UseCase_ChangeTrophyWeaponMode(param1, info);
        Menu_Settings(param1);
    } else if (action == MenuAction_Cancel) {
        if (param2 == MenuCancel_ExitBack) {
            ShowCookieMenu(param1);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_GiveTrophyWeapon(int client) {
    Menu menu = new Menu(MenuHandler_GiveTrophyWeapon);

    menu.SetTitle("%T", GIVE_TROPHY_WEAPON, client);

    Menu_AddAskItem(menu, ITEM_YES, client);
    Menu_AddAskItem(menu, ITEM_NO, client);

    menu.ExitButton = false;
    menu.Display(client, ASK_FOR_TROPHY_WEAPON_TIME);
}

public int MenuHandler_GiveTrophyWeapon(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

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

void Menu_AddAskItem(Menu menu, const char[] phrase, int client) {
    char item[ITEM_SIZE];

    Format(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(phrase, item);
}

void Menu_AddModeItem(Menu menu, const char[] mode, const char[] phrase, int client) {
    char item[ITEM_SIZE];
    int style = Menu_GetItemStyleForMode(client, mode);

    Format(item, sizeof(item), "%T", phrase, client);

    menu.AddItem(mode, item, style);
}

int Menu_GetItemStyleForMode(int client, const char[] mode) {
    char cookieValue[COOKIE_VALUE_SIZE];

    Cookie_GetTrophyWeaponMode(client, cookieValue);

    return strcmp(cookieValue, mode) == 0 ? ITEMDRAW_DISABLED : ITEMDRAW_DEFAULT;
}
