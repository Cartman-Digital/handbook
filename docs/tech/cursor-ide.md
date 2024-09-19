# Setting up Cursor IDE

To use AI-assisted programming at Cartman, the currently recommended solution is [Cursor IDE](https://www.cursor.sh/).

!!! warning

    Avoid using any other AI-assisted tools, such as ChatGPT, with our code, as they may process and store our prompts and code, potentially compromising security and confidentiality.

## Setting Up

To set up Cursor, follow these steps:

1. **Input OpenAI API Key**:
    - Input our own OpenAI API key and use only that API key. Do not use the Cursor subscription or Cursor without inputting the API key.
    - The API key can be found in [1Password](https://start.1password.com/open/i?a=A77NHIUOAFCT3HFO4YPZHQSW3I&v=554znu2kv24b2qwaoi6j453d7y&i=eklflibejctlr4obhuq5u6jsdq&h=cartman.1password.com).

2. **Enable Privacy Mode**:
    - Set _Privacy Mode_ to enabled, so that no code will ever be shipped out from the local machine.
    - **This is an extremely important step to get right before you open any projects on Cursor!** It is strictly forbidden to use Cursor without this setting enabled.
    - Steps to enable Privacy Mode:
        1. Go to Cursor settings either by clicking the gear in the top right or by pressing `Command/Ctrl + Shift + P` and selecting _Cursor settings_
        2. Scroll down and you should see a Privacy Mode section.

3. **Use GPT-4o Language Model**:
    - Ensure that the GPT-4o language model is selected for AI assistance.

## Usage

Generally, Cursor works the same as VSCode, except for the AI-assisted features. Refer to [Cursor Features](https://www.cursor.sh/features) for more information on how to use them.

