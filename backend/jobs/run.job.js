import { startProductBackup } from "./product.job.js";
import { startUserBackup } from "./user.job.js";

export const startBackup = () => {
  startProductBackup();
  startUserBackup();
};
