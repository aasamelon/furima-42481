const pay = () => {
  const payjp = Payjp('pk_test_2dded1e542f6d95064782e3b')
  
  const numberForm = document.getElementById('number-form');
  const expiryForm = document.getElementById('expiry-form');
  const cvcForm = document.getElementById('cvc-form');

  console.log('カード番号フォームのDOM:', numberForm);
  console.log('有効期限フォームのDOM:', expiryForm);
  console.log('CVCフォームのDOM:', cvcForm);

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

    payjp.createToken(numberElement).then(function (response) {
      console.log(response);
      
      
      if (response.error) {
      } else {
        const token = response.id;
        console.log(token)
      }
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value="${token}" name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
    });
  });
};


window.addEventListener("load", pay);
