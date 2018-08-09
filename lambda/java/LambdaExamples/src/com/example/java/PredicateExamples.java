package com.example.java;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Predicate;

public class PredicateExamples {

	public static void main(String[] args) {
		Predicate<String> nonEmptyPred = (String s) -> !s.isEmpty();
		
		List<String> listOfStrings = 
				Arrays.asList("Hello", "", "", "World", "", "!!");
		List<String> nonEmptyList = filter(listOfStrings, nonEmptyPred);
		System.out.println(nonEmptyList);
	}
	
	public static <T> List<T> filter(List<T> list, Predicate<T> p) {
		List<T> results = new ArrayList<>();
		for (T s : list) {
			if (p.test(s)) results.add(s);
		}
		return results;
	}

}
