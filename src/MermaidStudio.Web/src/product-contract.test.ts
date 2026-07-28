import { describe, expect, it } from "vitest";
import { productContract } from "./product-contract";

describe("productContract", () => {
  it("pins the Mermaid compatibility boundary", () => {
    expect(productContract.productName).toBe("Mermaid Studio");
    expect(productContract.mermaidVersion).toBe("11.16.0");
    expect(productContract.protocolVersion).toBe("1.0");
    expect(productContract.canonicalDiagramTypeCount).toBe(34);
  });
});
