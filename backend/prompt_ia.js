const { Configuration, OpenAIApi } = require("openai");
const configuration = new Configuration({
  apiKey: process.env.OPENAI_KEY,
});
const openai = new OpenAIApi(configuration);

function prompt_ia(prompt, message)
{
    return new Promise((res, rej)=>{
        prompt_final = ""
        prompt_final += prompt
        prompt_final += message
        openai.createCompletion({
            model: "text-davinci-003",
            prompt: prompt_final,
            max_tokens: 1000,
          }).then((val)=>{
            res(val.data.choices[0].text)
          }).catch((err)=>{
            rej(err);
          })
    })
}

module.exports = prompt_ia
