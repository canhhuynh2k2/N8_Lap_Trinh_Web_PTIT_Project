const form = document.getElementById("form");
const oldPassword = document.getElementById("old-password");
const password = document.getElementById("password");
const confirmPassword = document.getElementById("confirm-password");

const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/;

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
  const oldPasswordValue = oldPassword.value.trim()
  const passwordValue = password.value.trim()
  const confirmPasswordValue = confirmPassword.value.trim()

  if (!isGoodPassword(oldPasswordValue)) {
    setErrorFor(oldPassword, "Mật khẩu ít nhất 8 kí tự trong đó có chứa 1 chữ thường, 1 chữ hoa, 1 chữ số");
    oldPassword.focus()
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

oldPassword.addEventListener("blur", () => {
  if (isGoodPassword(oldPassword.value.trim())) {
    setSuccessFor(oldPassword)
  } else {
    setErrorFor(oldPassword, "Mật khẩu ít nhất 8 kí tự trong đó có chứa 1 chữ thường, 1 chữ hoa, 1 chữ số");
    oldPassword.focus()
  }
})

oldPassword.addEventListener("input", () => {
  setDefaultFor(oldPassword);
})

password.addEventListener("blur", () => {
  if (isGoodPassword(password.value.trim())) {
    setSuccessFor(password)
  } else {
    setErrorFor(password, "Mật khẩu ít nhất 8 kí tự trong đó có chứa 1 chữ thường, 1 chữ hoa, 1 chữ số");
    password.focus()
  }
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
