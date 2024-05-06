import { TurboModule, TurboModuleRegistry } from "react-native";

interface RequestGalleryImageResult {
  isSuccess?: boolean;
  imageUri?: string;
}

export interface Spec extends TurboModule {
  requestGalleryImage(): Promise<RequestGalleryImageResult>;
}

// export const gallery = TurboModuleRegistry.get<Spec>("RTNMyGallery") as Spec | null;
export default TurboModuleRegistry.get<Spec>("RTNMyGallery") as Spec | null;