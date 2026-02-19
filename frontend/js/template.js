/**
 * Builds template strings with replacements.
 * @param template Template string with replacements. 
 * @param replacements Object with keys as replacements and values as replacement values. 
 * @example
 * const template = "Hello, $NAME$!";
 * const replacements = { '$NAME$': 'John Doe' };
 * const result = templateReplace(template, replacements);
 * console.log(result); // "Hello, John Doe!"
 */
export function templateReplace(template, replacements) {
  let element = template;

  for (const key in replacements) {
    const value = replacements[key];
    element = element.replace(key, value);
  }

  return element;
}
