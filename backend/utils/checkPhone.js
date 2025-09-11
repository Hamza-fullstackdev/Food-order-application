const containsOnlyNumbers = (phone) => {
  const numberPattern = /^\d+$/;
  return numberPattern.test(phone);
};

export default containsOnlyNumbers;
