package com.example.java;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class LambdaExamplesUsingStream {
	public static void main(String[] args) {
		
		// 간단한 람다 예제 1:
		Runnable r = () -> { System.out.println("Hello!"); };
		
		new Thread(r).start();
		
		// 필터링에 람다를 사용한 예제 2 (스트림을 사용한 버전):
		List<Apple> inventory = Arrays.asList(
				new Apple(80, "green"),
				new Apple(155, "green"),
				new Apple(120, "red"));
		System.out.println("The original stream: " + inventory);
		
		List<Apple> greenApples = 
				inventory
					.stream()
					.filter((Apple a) -> "green".equals(a.getColor()))
					.collect(Collectors.toList());
		System.out.println("The filtered stream: " + greenApples);

		// 정렬에 람다를 사용한 예제 3 (스트림을 사용한 버전):	
		Comparator<Apple> byWeight =
				(Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
			
		inventory.stream().sorted(byWeight);
		System.out.print("The sorted list: " + inventory); 
	}

	public static class Apple {
		private int weight;
		private String color;
		
		public Apple(int weight, String color) {
			this.weight = weight;
			this.color = color;
		}

		public Integer getWeight() {
			return weight;
		}
		
		public String getColor() {
			return color;
		}

		public void setColor(String color) {
			this.color = color;
		}

		public String toString() {
			return "Apple{" + "color=\'" + color + '\'' +
					", weight=" + weight + "}";
		}
		
	}

}
