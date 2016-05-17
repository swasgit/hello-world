package com.swasnet;

import org.junit.Assert;
import org.junit.Test;

public class AppTest {

	@Test
	public void testMessage() {
		App obj = new App();
		Assert.assertEquals("Hello World!!", obj.getMessage());
	}
}
