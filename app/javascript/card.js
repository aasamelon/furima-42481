const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        console.error(response.error.message);

        const errorMessageContainer = document.querySelector('.error-messages');
        if (errorMessageContainer) {
          errorMessageContainer.innerHTML = `
            <ul><li style="color:red;">・${response.error.message}</li></ul>
          `;
        } else {
          alert(response.error.message);
        }

        return;
      }

      const token = response.id;
      const tokenObj = `<input type="hidden" name="order_shipping_form[token]" value="${token}">`;
      form.insertAdjacentHTML("beforeend", tokenObj);
      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
