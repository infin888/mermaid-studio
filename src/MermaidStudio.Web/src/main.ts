import "./styles.css";
import { productContract } from "./product-contract";

const root = document.querySelector<HTMLElement>("#app");

if (!root) {
  throw new Error("Workspace root was not found.");
}

root.innerHTML = `
  <section class="foundation" aria-labelledby="foundation-title">
    <span class="eyebrow">Native workspace host ready</span>
    <h1 id="foundation-title">${productContract.productName}</h1>
    <p>Mermaid ${productContract.mermaidVersion} · protocol ${productContract.protocolVersion}</p>
  </section>
`;
