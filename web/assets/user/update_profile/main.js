const form = document.getElementById("form");
const fullName = document.getElementById("full-name")
const phoneNumber = document.getElementById("phone-number");

const phoneNumberRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;

const isName = (fullName) => {
  return fullName.length >= 2;
}

const isPhoneNumber = (phoneNumber) => {
  return phoneNumber.match(phoneNumberRegex)
}

const setSuccessFor = (input) => {
  const formGroup = input.parentElement;
  const errorIcon = formGroup.querySelector(".error-icon");
  const successIcon = formGroup.querySelector(".success-icon");
  const errorMessage = formGroup.lastElementChild;

  if (input.classList.contains("error")) {
    input.classList.remove("error");
  }

  if (!input.classList.contains("success")) {
    input.classList.add("success");
  }

  if (errorIcon.classList.contains("visible")) {
    errorIcon.classList.remove("visible");
  }

  if (!successIcon.classList.contains("visible")) {
    successIcon.classList.add("visible");
  }

  if (errorMessage.classList.contains("visible")) {
    errorMessage.innerText = "Error";
    errorMessage.classList.remove("visible");
  }

}

const setErrorFor = (input, message) => {
  const formGroup = input.parentElement;
  const errorIcon = formGroup.querySelector(".error-icon");
  const successIcon = formGroup.querySelector(".success-icon");
  const errorMessage = formGroup.lastElementChild;

  if (input.classList.contains("success")) {
    input.classList.remove("success");
  }

  if (!input.classList.contains("error")) {
    input.classList.add("error");
  }

  if (!errorIcon.classList.contains("visible")) {
    errorIcon.classList.add("visible")
  }

  if (successIcon.classList.contains("visible")) {
    successIcon.classList.remove("visible")
  }

  errorMessage.innerText = message;
  errorMessage.classList.add("visible");
}

const setDefaultFor = (input) => {
  const formGroup = input.parentElement;
  const errorIcon = formGroup.querySelector(".error-icon");
  const successIcon = formGroup.querySelector(".success-icon");
  const errorMessage = formGroup.lastElementChild;

  if (input.classList.contains("success")) {
    input.classList.remove("success");
  }

  if (input.classList.contains("error")) {
    input.classList.remove("error");
  }

  if (errorIcon.classList.contains("visible")) {
    errorIcon.classList.remove("visible")
  }

  if (successIcon.classList.contains("visible")) {
    successIcon.classList.remove("visible")
  }

  if (errorMessage.classList.contains("visible")) {
    errorMessage.innerText = "Error";
    errorMessage.classList.remove("visible");
  }
}


form.addEventListener("submit", (evt) => {
  evt.preventDefault();
  checkInputs();
})

const checkInputs = () => {
  const fullNameValue = fullName.value.trim()
  const phoneNumberValue = phoneNumber.value.trim()

  if (!isName(fullNameValue)) {
    setErrorFor(fullName, "Vui lòng nhập tên");
    fullName.focus();
  } else if (!isPhoneNumber(phoneNumberValue)) {
    setErrorFor(phoneNumber, "Vui lòng nhập số điện thoại đúng định dạng!");
    phoneNumber.focus();
  } else {
    form.submit();
  }
}

fullName.addEventListener("blur", () => {
  const fullNameValue = fullName.value.trim()
  if (isName(fullNameValue)) {
    setSuccessFor(fullName)
  } else {
    setErrorFor(fullName, "Vui lòng nhập tên!");
    fullName.focus();
  }
})

fullName.addEventListener("input", () => {
  setDefaultFor(fullName)
})

phoneNumber.addEventListener("blur", () => {
  const phoneNumberValue = phoneNumber.value.trim()
  if (isPhoneNumber(phoneNumberValue)) {
    setSuccessFor(phoneNumber)
  } else {
    setErrorFor(phoneNumber, "Vui lòng nhập số điện thoại đúng định dạng!");
    phoneNumber.focus();
  }
})

phoneNumber.addEventListener("input", () => {
  setDefaultFor(phoneNumber)
})
