enum AccessorySlot { hair, hat, glasses, mask, outfit, back, wrist }

extension AccessorySlotLabel on AccessorySlot {
  String get key {
    return switch (this) {
      AccessorySlot.hair => 'hair',
      AccessorySlot.hat => 'hat',
      AccessorySlot.glasses => 'glasses',
      AccessorySlot.mask => 'mask',
      AccessorySlot.outfit => 'outfit',
      AccessorySlot.back => 'back',
      AccessorySlot.wrist => 'wrist',
    };
  }

  String get label {
    return switch (this) {
      AccessorySlot.hair => 'Hair',
      AccessorySlot.hat => 'Hats',
      AccessorySlot.glasses => 'Glasses',
      AccessorySlot.mask => 'Masks',
      AccessorySlot.outfit => 'Outfits',
      AccessorySlot.back => 'Back',
      AccessorySlot.wrist => 'Wrist',
    };
  }
}
