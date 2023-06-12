const form = document.getElementById("form");
const email = document.getElementById("email");
const password = document.getElementById("password");

const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/;

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
  const emailValue = email.value.trim()
  const passwordValue = password.value.trim()

  if (!isEmail(emailValue)) {
    setErrorFor(email, "Email không đúng định dạng!");
    email.focus();
  } else if (!isGoodPassword(passwordValue)) {
    setErrorFor(password, "Mật khẩu ít nhất 8 kí tự trong đó có chứa 1 chữ thường, 1 chữ hoa, 1 chữ số");
    password.focus()
  } else {
    form.submit();
  }
}

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