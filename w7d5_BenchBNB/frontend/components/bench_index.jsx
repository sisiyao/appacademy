import React from 'react';
import BenchIndexItem from './bench_index_item';

class BenchIndex extends React.Component{
  constructor (props) {
    super(props);
  }

  // componentDidMount () {
  //   this.props.requestBenches();
  // }

  render () {
    const benchesList = this.props.benches.map(bench => (
      <BenchIndexItem bench={bench} key={`${bench.id}${bench.description}`}/>
    ));

    return (
      <div>
        <ul>
          {benchesList}
        </ul>
      </div>
    );
  }
}

export default BenchIndex;
