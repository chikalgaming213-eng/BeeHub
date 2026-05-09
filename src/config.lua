-- Konfigurasi Bee Hub
getgenv().BeeConfig = {
    Team = "Pirates", -- "Pirates" or "Marines"
    HideUI = false,
    AutoBounty = false,
    KillAura = false,
    LockTarget = false,
    LockBounty = { Enabled = false, Min = 0, Max = 30000000 },
    Skip = {
        Fruit = false,
        FruitSkip = {"Buddha", "Tiger", "T-Rex"},
        SafeZone = true,
        NoHaki = true,
        NoPvP = true
    },
    SafeHealth = {
        Health = 4700,
        Mask = false,
        MaskType = "Mask",
        RaceV4 = false
    },
    Setting = {
        UseRaceV3 = true,
        UseRaceV4 = true,
        SafeHealth = true,
        SkipV4Race = true,
        Health = 4700,
        FPSBoots = true,
        AutoServerHop = true,
        CheckCombatBeforeHop = true,
        FastAttack = true
    },
    Webhook = { Enabled = false, Url = "" },
    AimBot = {
        Enabled = false,
        AimCamera = { Enabled = false, MaxDistance = 300 },
        LockAim = { Enabled = false }
    },
    DelayConfig = {
        MeleeZ = 0.1, MeleeX = 0.1, MeleeC = 0.1, ChangeDelay = 0.5,
        SwordZ = 0.1, SwordX = 0.1,
        GunZ = 0.1, GunX = 0.1,
        FruitZ = 0.1, FruitX = 0.1, FruitC = 0.1, FruitV = 0.1, FruitF = 0.1
    },
    FarmDelay = 0.22
}
print("Config loaded")
