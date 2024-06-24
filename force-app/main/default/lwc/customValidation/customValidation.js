import { LightningElement } from "lwc";

export default class CustomValidation extends LightningElement {
  handleClick() {
    this.setValidation(".nameInput", "Name is required..");
    this.setValidation(".dateInput", "Date is required...");
  }

  setValidation(selector, message) {
    let inputField = this.template.querySelector(selector);
    let value = inputField.value;
    if (!value) {
      inputField.setCustomValidity(message);
    } else {
      inputField.setCustomValidity("");
    }
    inputField.reportValidity();
  }
}
