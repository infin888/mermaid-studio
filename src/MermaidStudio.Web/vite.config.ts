import { fileURLToPath, URL } from "node:url";
import { defineConfig } from "vitest/config";

export default defineConfig({
  base: "./",
  build: {
    outDir: fileURLToPath(new URL("../MermaidStudio/WebAssets", import.meta.url)),
    emptyOutDir: true,
    sourcemap: true,
  },
  test: {
    environment: "node",
  },
});
