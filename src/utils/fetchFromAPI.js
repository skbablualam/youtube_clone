import axios from 'axios';

export const BASE_URL = 'https://youtube-v311.p.rapidapi.com';

const options = {
  params: { maxResults: '50' },
  headers: {
    // TEMPORARY: Hardcode the key here to see if the UI works.
    // If this works, the Jenkins injection was the only problem.
    'X-RapidAPI-Key': process.env.REACT_APP_RAPID_API_KEY, 
    'X-RapidAPI-Host': 'youtube-v311.p.rapidapi.com',
  },
};

export const fetchFromAPI = async (url) => {
  const { data } = await axios.get(`${BASE_URL}/${url}`, options);
  return data;
};