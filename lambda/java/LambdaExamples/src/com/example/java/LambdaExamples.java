package com.example.java;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.Supplier;

public class LambdaExamples {

	public static void main(String[] args) {
		
		// 간단한 람다 예제 1:
		Runnable r = () -> { System.out.println("Hello!"); };
		
		new Thread(r).start();
		
		// 필터링에 람다를 사용한 예제 2:
		List<Apple> inventory = Arrays.asList(
				new Apple(80, "green"),
				new Apple(155, "green"),
				new Apple(120, "red"));
		System.out.println("The original list: " + inventory);
		
		List<Apple> greenApples = filter(inventory, (Apple a) -> "green".equals(a.getColor()));
		System.out.println("The filtered list: " + greenApples);

		// 정렬에 람다를 사용한 예제 3:	
		Comparator<Apple> byWeight =
				(Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
			
		inventory.sort((Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight()));
		System.out.println("The sorted list: " + inventory);
		
		// 메소드 레퍼런스를 사용하여 예제 3 (Line 31)을 변경한 예제 4:
		// inventory.sort((Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight()));
		inventory.sort(Comparator.comparing(Apple::getWeight));

		// 메소드 레퍼런스 (생성자)를 사용한 예제 5:
		Supplier<Apple> s = Apple::new;
//		Supplier<Apple> s = () -> new Apple();
		Apple apple_s = s.get();
		System.out.println(apple_s);
		
		Function<Integer,Apple> f = Apple::new;
		Apple apple_f = f.apply(110);
		System.out.println(apple_f);
		
		BiFunction<Integer,String,Apple> bf = Apple::new;
		Apple apple_bf = bf.apply(200,  "green");
		System.out.println(apple_bf);
		
		// 람다식을 조합하는 예제 6:
		// c 기준으로 정렬
		Comparator<Apple> c = Comparator.comparing(Apple::getWeight);
		
		//역 정렬
		inventory.sort(Comparator.comparing(Apple::getWeight).reversed());
		System.out.println(inventory);
		
		// 여러 Comparator를 연결
		inventory.sort(
				Comparator.comparing(Apple::getWeight)
				.reversed()
				.thenComparing(Apple::getCountry));
		
		// Predicate 조합
		Predicate<Apple> redApple = (Apple a) -> "red".equals(a.getColor());
		Predicate<Apple> notRedApple = redApple.negate();
		
		Predicate<Apple> redAndHeavyApple =
				redApple.and(a -> a.getWeight() > 150);
		
		Predicate<Apple> redAndHeavyApplrOrGreen =  
				// 빨간색이면서 무거운(150 이상) 사과 또는 그냥 녹색 사과 (왼쪽에서 오른쪽으로 괄호)
				redApple.and(a -> a.getWeight() > 150)
					.or(a -> "green".equals(a.getColor()));
		
		// Function 조합
		int result;
		
		Function<Integer, Integer> addone = x -> x + 1;
		Function<Integer, Integer> multwo = x -> x * 2;
		Function<Integer, Integer> h = addone.andThen(multwo);
		result = h.apply(1);		// result는 4 = (1 + 1) * 2
		
		Function<Integer, Integer> g = addone.compose(multwo);
		result = g.apply(1);   // result는 3 = (1 * 2) + 2 
		
		
	}

	
	public static List<Apple> filter(List<Apple> inventory, ApplePredicate p) {
		List<Apple> result = new ArrayList<>();
		for (Apple apple : inventory) {
			if (p.test(apple)) {
				result.add(apple);
			}
		}
		return result;
	}
	
	public static class Apple {
		private int weight;
		private String color;
		private String country;
		
		public Apple(int weight, String color, String country) {
			this.weight = weight;
			this.color = color;
			this.country = country;
		}
		
		public Apple(int weight, String color) {
			this(weight, color, "Korea");
		}
		
		public Apple() {
			this(30, "blue","Korea");
		}
		
		public Apple(int weight) {
			this(weight, "black", "Korea");
		}

		public Integer getWeight() {
			return weight;
		}
		
		public String getColor() {
			return color;
		}
		
		public String getCountry() {
			return country;
		}

		public String toString() {
			return "Apple{" + "color=\'" + color + '\'' +
					", weight=" + weight + "}";
		}
		
	}
	
	interface ApplePredicate {
		public boolean test(Apple a);
	}
}

