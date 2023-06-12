const form = document.getElementById("form");
const fullName = document.getElementById("full-name")
const phoneNumber = document.getElementById("phone-number");
const email = document.getElementById("email");
const password = document.getElementById("password");
const confirmPassword = document.getElementById("confirm-password");

const phoneNumberRegex = /(84|0[3|5|7|8|9])+([0-9]{8})\b/g;
const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/;

const isName = (fullName) => {
  return fullName.length >= 2;
}

const isPhoneNumber = (phoneNumber) => {
  return phoneNumber.match(phoneNumberRegex)
}

const isEmail = (email) => {
  return email.match(emailRegex)
}

const isGoodPassword = (password) => {
  return password.match(passwordRegex)
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
  const emailValue = email.value.trim()
  const passwordValue = password.value.trim()
  const confirmPasswordValue = confirmPassword.value.trim()

  if (!isName(fullNameValue)) {
    setErrorFor(fullName, "Vui lòng nhập tên");
    fullName.focus();
  } else if (!isPhoneNumber(phoneNumberValue)) {
    setErrorFor(phoneNumber, "Vui lòng nhập số điện thoại đúng định dạng!");
    phoneNumber.focus();
  } else if (!isEmail(emailValue)) {
    setErrorFor(email, "Email không đúng định dạng!");
    email.focus();
  } else if (!isGoodPassword(passwordValue)) {
    setErrorFor(password, "Mật khẩu ít nhất 8 kí tự trong đó có chứa 1 chữ thường, 1 chữ hoa, 1 chữ số");
    password.focus()
  } else if (!(passwordValue === confirmPasswordValue)) {
    setErrorFor(confirmPassword, "Mật khẩu không khớp!");
    confirmPassword.focus();
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

email.addEventListener("blur", () => {
  if (isEmail(email.value.trim())) {
    setSuccessFor(email)
  } else {
    setErrorFor(email, "Email không đúng định dạng!");
    email.focus();
  }
})

email.addEventListener("input", () => {
  setDefaultFor(email)
})

password.addEventListener("input", () => {
  confirmPassword.value = "";
  setDefaultFor(confirmPassword);
  setDefaultFor(password);
})

confirmPassword.addEventListener("input", () => {
  if (password.value.trim() === confirmPassword.value.trim()) {
    setSuccessFor(confirmPassword);
  } else {
    setErrorFor(confirmPassword, "Mật khẩu không khớp!");
  }
})
