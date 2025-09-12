import bcrypt from "bcryptjs";

const hashPassword = async (password, saltRounds = 10) => {
  const salt = await bcrypt.genSalt(saltRounds);
  const hashedPassword = await bcrypt.hash(password, salt);
  return hashedPassword;
};
const comparePassword = async (password, hashedPassword) => {
  const isMatch = await bcrypt.compare(password, hashedPassword);
  return isMatch;
}

export { hashPassword, comparePassword };
