const API_URL = 'http://localhost:5000/';

export async function get(route) {
  const response = await fetch(`${API_URL}${route}`);
  if(!response.ok) {
    throw new Error(`GET request failed with ${response.status}.`);
  }

  const result = await response.json();

  return result;
}
