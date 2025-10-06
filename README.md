# ripple-chartjs

Ripple components for Chart.js

> [!WARNING]
> Ripple is still in early development, and should not be used in production.

## Installation

```bash
npm install ripple-chartjs chart.js
```

## Usage

```ts
import { Chart, Title, Tooltip, Legend, Colors } from 'chart.js'
import { Line } from 'ripple-chartjs'
import { track } from 'ripple'

Chart.register(Title, Tooltip, Legend, Colors)

export component App() {
    let chartData = track({
        labels: ['January', 'February', 'March', 'April', 'May'],
        datasets: [
            {
                label: 'Sales',
                data: [50, 60, 70, 80, 90],
            },
        ],
    })
    const chartOptions = {
        responsive: true,
        maintainAspectRatio: false,
    }

    <Line data={@chartData} options={chartOptions} width={500} height={500} />
}
```

## Props

| Prop    | Description                               | Type                                                                                                  |
| ------- | ----------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| width   | The width of the chart canvas in pixels.  | number \| undefined                                                                                   |
| height  | The height of the chart canvas in pixels. | number \| undefined                                                                                   |
| type    | The type of the chart.                    | keyof [ChartTypeRegistry](https://www.chartjs.org/docs/latest/api/interfaces/ChartTypeRegistry.html)  |
| data    | The chart data object.                    | [ChartData](https://www.chartjs.org/docs/latest/api/interfaces/ChartData.html) \| undefined           |
| options | The chart options object.                 | [ChartOptions](https://www.chartjs.org/docs/latest/api/interfaces/CoreChartOptions.html) \| undefined |
| plugins | The chart plugins object.                 | [Plugin](https://www.chartjs.org/docs/latest/api/interfaces/Plugin.html)[] \| undefined               |

## License

MIT
