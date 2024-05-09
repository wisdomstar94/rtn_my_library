import { TurboModule, TurboModuleRegistry } from "react-native";

interface MyObject {
  name: string;
  age: number;
}

export interface Spec extends TurboModule {
  getRtnMyLibraryVersion(): Promise<string>;
  getDeviceModel(): Promise<string>;
  requestGalleryImage(): Promise<string>;
  getObjectTest(): Promise<MyObject>;
}

// export const library = TurboModuleRegistry.get<Spec>("RTNMyLibrary") as Spec | null;
export default TurboModuleRegistry.get<Spec>("RTNMyLibrary") as Spec | null;