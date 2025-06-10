const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput || !addTaxDom || !profitDom) return;

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value); // 数値に変換

    if (!isNaN(inputValue)) {
      const tax = Math.floor(inputValue * 0.1); // 販売手数料10%
      const profit = inputValue - tax;          // 利益 = 入力金額 - 手数料
      addTaxDom.textContent = tax;
      profitDom.textContent = profit;
    } else {
      addTaxDom.textContent = '';
      profitDom.textContent = '';
    }
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
