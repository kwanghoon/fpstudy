package com.example.java;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;

public class FunctionExample {

	public static void main(String[] args) {
		List<String> list = Arrays.asList("lambdas", "8", "in", "action");
		forEach(
			map (list, (String s) -> s.length()),
			(Integer i) -> System.out.println(i));
	}

	public static <T, R> List<R> map(List<T> list, Function<T, R> f) {
		List<R> result = new ArrayList<>();
		for (T e : list) 
			result.add(f.apply(e));
		return result;
	}
	
	public static <T> void forEach(List<T> list, Consumer<T> c) {
		   for (T e : list) {
		       c.accept(e);
		   }
	}
}
