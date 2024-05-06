import { TurboModule, TurboModuleRegistry } from "react-native";

interface RequestGalleryImageResult {
  isSuccess?: boolean;
  imageUri?: string;
}

export interface Spec extends TurboModule {
  getDeviceModel(): Promise<string>;
  requestGalleryImage(): Promise<RequestGalleryImageResult>;
}

// export const library = TurboModuleRegistry.get<Spec>("RTNMyLibrary") as Spec | null;
export default TurboModuleRegistry.get<Spec>("RTNMyLibrary") as Spec | null;