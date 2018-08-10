package com.example.java;

import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;

public class ConsumerExamples {

	public static void main(String[] args) {
		List<Integer> list = Arrays.asList(1, 3, 5, 7, 9);
		forEach(list, (Integer i) -> System.out.println(i));
	}
	
	public static <T> void forEach(List<T> list, Consumer<T> c) {
		for (T i : list) {
			c.accept(i);
		}
	}

}
