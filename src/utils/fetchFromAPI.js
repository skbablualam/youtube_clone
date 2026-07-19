import axios from 'axios';

// Update this line in src/utils/fetchFromAPI.js (or wherever it lives)
export const BASE_URL = 'https://youtube-v311.p.rapidapi.com';

const options = {
  params: {
    maxResults: '50',
  },
  headers: {
    'X-RapidAPI-Key': process.env.REACT_APP_RAPID_API_KEY,
    'X-RapidAPI-Host': 'youtube-v311.p.rapidapi.com', // Match the URL!
  },
};

export const fetchFromAPI = async (url) => {
  const { data } = await axios.get(`${BASE_URL}/${url}`, options);

  return data;
};