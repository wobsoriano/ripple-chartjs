import type { ChartType, DefaultDataPoint } from "chart.js";
import type { ChartProps, TypedChartProps } from "../lib/types";


export declare function Chart(props: ChartProps<ChartType, DefaultDataPoint<ChartType>>)

export declare function Line(props: TypedChartProps<'line', DefaultDataPoint<'line'>>): void;
export declare function Bar(props: TypedChartProps<'bar', DefaultDataPoint<'bar'>>): void;
export declare function Radar(props: TypedChartProps<'radar', DefaultDataPoint<'radar'>>): void;
export declare function Doughnut(props: TypedChartProps<'doughnut', DefaultDataPoint<'doughnut'>>): void;
export declare function PolarArea(props: TypedChartProps<'polarArea', DefaultDataPoint<'polarArea'>>): void;
export declare function Bubble(props: TypedChartProps<'bubble', DefaultDataPoint<'bubble'>>): void;
export declare function Pie(props: TypedChartProps<'pie', DefaultDataPoint<'pie'>>): void;
export declare function Scatter(props: TypedChartProps<'scatter', DefaultDataPoint<'scatter'>>): void;
