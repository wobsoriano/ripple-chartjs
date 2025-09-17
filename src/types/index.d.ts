import type { ChartType, DefaultDataPoint } from "chart.js";
import type { ChartProps } from "../lib/types";


export declare function Chart(props: ChartProps<ChartType, DefaultDataPoint<ChartType>>)

export declare function Line(props: ChartProps<'line', DefaultDataPoint<'line'>>): void;
export declare function Bar(props: ChartProps<'bar', DefaultDataPoint<'bar'>>): void;
export declare function Radar(props: ChartProps<'radar', DefaultDataPoint<'radar'>>): void;
export declare function Doughnut(props: ChartProps<'doughnut', DefaultDataPoint<'doughnut'>>): void;
export declare function PolarArea(props: ChartProps<'polarArea', DefaultDataPoint<'polarArea'>>): void;
export declare function Bubble(props: ChartProps<'bubble', DefaultDataPoint<'bubble'>>): void;
export declare function Pie(props: ChartProps<'pie', DefaultDataPoint<'pie'>>): void;
export declare function Scatter(props: ChartProps<'scatter', DefaultDataPoint<'scatter'>>): void;
