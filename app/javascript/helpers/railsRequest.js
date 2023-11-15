import { FetchRequest } from "@rails/request.js";

export const getBaseUrl = () => {
  if (window && window !== undefined) {
    return window.location.origin;
  }
};

export const fetchRails = (path, params = {}) => {
  const { method = "post", body, query } = params;

  const baseUrl = getBaseUrl();
  return new Promise(async (resolve, reject) => {
    const request = new FetchRequest(method, `${baseUrl}${path}`, {
      contentType: "application/json",
      body: JSON.stringify(body),
    });
    const response = await request.perform();
    if (response.ok) {
      const body = await response.json;
      resolve(body);
    } else {
      reject("Error fetching from rails");
    }
  });
};
