import { TurboModule, TurboModuleRegistry } from "react-native";

export interface Spec extends TurboModule {
  getDeviceModel(): Promise<string>;
  requestGalleryImage(): Promise<string>;
}

// export const library = TurboModuleRegistry.get<Spec>("RTNMyLibrary") as Spec | null;
export default TurboModuleRegistry.get<Spec>("RTNMyLibrary") as Spec | null;