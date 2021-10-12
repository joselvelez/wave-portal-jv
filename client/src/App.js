import { useState } from 'react';
import './App.css';
import { Wave } from './Wave';

function App() {
  const [currentTheme, setTheme] = useState('light');

  document.body.setAttribute('theme', currentTheme);

  const switchTheme = () => {
    setTheme(currentTheme !== "light" ? "light" : "dark");
  };

  return (
    <section>
      <div className="theme-switcher">
        <input type="checkbox" id="switcher" onChange={() => switchTheme()} />
        <label htmlFor="switcher">Switch</label>
      </div>
      <div className="mainContainer">
        <div className="greeting">
          <div>
          👋 Hi folks!
          </div>
          <div>
            <p>I am Jose and I'm looking to transition from finance to web3. Web3 is going to fundamentally change how we interact online.</p>
            <p>I want to be a part of that transformation!</p>
          </div>
        </div>
        <div className="content">
          <p>Put some content here</p>
        </div>

        <div className="app">
          <Wave />
        </div>
      </div>
    </section>
  );
}

export default App;
