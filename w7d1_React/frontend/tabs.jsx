import React from 'react';

class Tabs extends React.Component {
  constructor (props) {
    super(props);
    this.state = {selected: 0};
  }

  changeTab (idx) {
    this.setState({selected: idx});
  }

  render () {
    const tabTitle = this.props.tabsData.map((tab, idx) => {
      const className = idx === this.state.selected ? 'tabs-li selected' : 'tabs-li';
      return (
        <li key={idx} onClick={this.changeTab.bind(this, idx)} className={className}>
          <h3>{tab.title}</h3>
        </li>
      );
    });

    return (
      <div className="widget">
        <h2>Tabs</h2>
        <div className="tabs">
          <ul className='tabs-ul'>
            {tabTitle}
          </ul>
          <article className="tabs-content">
            {this.props.tabsData[this.state.selected].content}
          </article>
        </div>
      </div>
    );
  }
}

export default Tabs;
