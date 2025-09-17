import type { ChartType, DefaultDataPoint } from "chart.js";
import type { ChartProps } from "../lib/types";


export declare function Chart(props: ChartProps<ChartType, DefaultDataPoint<ChartType>>)

export declare function Line(props: Omit<ChartProps<'line', DefaultDataPoint<'line'>>, '$type'>): void;
export declare function Bar(props: Omit<ChartProps<'bar', DefaultDataPoint<'bar'>>, '$type'>): void;
export declare function Radar(props: Omit<ChartProps<'radar', DefaultDataPoint<'radar'>>, '$type'>): void;
export declare function Doughnut(props: Omit<ChartProps<'doughnut', DefaultDataPoint<'doughnut'>>, '$type'>): void;
export declare function PolarArea(props: Omit<ChartProps<'polarArea', DefaultDataPoint<'polarArea'>>, '$type'>): void;
export declare function Bubble(props: Omit<ChartProps<'bubble', DefaultDataPoint<'bubble'>>, '$type'>): void;
export declare function Pie(props: Omit<ChartProps<'pie', DefaultDataPoint<'pie'>>, '$type'>): void;
export declare function Scatter(props: Omit<ChartProps<'scatter', DefaultDataPoint<'scatter'>>, '$type'>): void;
