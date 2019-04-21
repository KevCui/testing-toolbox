// A script fetches temp mail address from temp-mail.org
//
// Dependency:
//   ~$ npm i puppeteer --ignore-scripts  
//   
// How to use:
//   ~$ node tempmail.js

const puppeteer = require('puppeteer');

(async () => {
  const chrome = '/usr/bin/chromium'; // Change browser path accordingly
  const isheadless = true;
  const url = 'https://temp-mail.org/' 
  const maincontent='.temp-emailbox';

  const browser = await puppeteer.launch({executablePath: chrome, headless: isheadless});
  const page = await browser.newPage();
  await page.goto(url, {timeout: 60000, waitUntil: 'domcontentloaded'});
  await page.waitFor(maincontent);
  const email = await page.evaluate(() => document.querySelector('#mail').getAttribute('value'));
  console.log(email)

  await browser.close();
})();
